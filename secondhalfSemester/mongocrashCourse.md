# MongoDB Crash Course

# Exam allow only this material

<https://www.mongodb.com/docs/development/>

---

## 1. DATABASE COMMANDS

### List all databases

```js
db.adminCommand({ listDatabases: 1 })
```

### Create (or use existing) database

```js
use classdb
```

---

## 2. CREATE / INSERT

### Insert one document

```js
db.movies.insertOne({ name: "Jurassic Park" })
```

### Insert multiple documents

```js
db.movies.insertMany([
  { name: "Toy Story", company: "Pixar" },
  { name: "Mad Max" }
])
```

### Insert multiple students

```js
db.students.insertMany([
  { name: "Tomy", age: 17, score: 80 },
  { name: "Jane", age: 18, score: 85 },
  { name: "Sally", age: 19, score: 84 }
])
```

### Insert students with class arrays

```js
db.students.insertMany([
  { name: "Aaron", age: 17, score: 80, classes: [111, 208, 239] },
  { name: "Brian", age: 18, score: 85, classes: [111, 200, 239] },
  { name: "Carla", age: 19, score: 84, classes: [187, 208, 438] }
])
```

---

## 3. READ / FIND

### Find all documents

```js
db.movies.find()
```

### Find by equality

```js
db.students.find({ name: "Sally" })
db.students.find({ score: 84 })
```

### Find documents containing a value in an array

```js
db.students.find({ classes: 111 })
```

### Find not equal

```js
db.students.find({ score: { $ne: 84 } })
```

### Comparison operators

```js
db.students.find({ score: { $gte: 84 } })   // Greater than or equal
db.students.find({ score: { $gt: 84 } })    // Greater than
db.students.find({ score: { $lt: 84 } })    // Less than
db.students.find({ score: { $lte: 84 } })   // Less than or equal
```

### Find where value is in or not in a list

```js
db.students.find({ name: { $in: ["Jane", "Sally"] } })
db.students.find({ name: { $nin: ["Jane", "Sally"] } })
```

### Complex find condition ($elemMatch)

```js
db.students.find({ classes: { $elemMatch: { $eq: 111 } } })
```

### Check if field exists or not

```js
db.students.find({ classes: { $exists: true } })
db.students.find({ classes: { $exists: false } })
```

---

## 4. PROJECTION (SHOW / HIDE FIELDS)

0 = hide, 1 = show

### Filtered example

```js
db.students.find(
  { classes: { $exists: false } },
  { score: 1, age: 1, _id: 0 }
)
```

### Without filter (show all)

```js
db.students.find(
  {},
  { score: 1, age: 1, _id: 0 }
)
```

---

## 5. SORTING AND LIMITING

### Decreasing order (max to min)

```js
db.students.find({}, { score: 1, age: 1, _id: 0 }).sort({ score: -1 })
```

### Decreasing order with limit

```js
db.students.find({}, { score: 1, age: 1, _id: 0 }).sort({ score: -1 }).limit(4)
```

### Increasing order (min to max)

```js
db.students.find({}, { score: 1, age: 1, _id: 0 }).sort({ score: 1 })
```

---

## 6. LOGICAL CONDITIONS

### AND condition

```js
db.students.find({ age: 17, score: 90 })
```

### OR condition

```js
db.students.find({ $or: [{ age: 18 }, { score: 90 }] })
```

### Range condition

```js
db.students.find({ score: { $gte: 84, $lte: 85 } })
```

---

## 7. UPDATE / REPLACE

### Replace an entire document (Dangerous)

```js
db.students.replaceOne({ name: "Sally" }, { score: 89 })
```

⚠️ This removes all old fields, leaving only `{ score: 89 }`.

### Update one field safely

```js
db.students.updateOne(
  { name: "Aaron" },
  { $set: { score: 89 } }
)
```

### Update multiple documents

```js
db.students.updateMany(
  { score: { $lt: 85 } },
  { $set: { status: "Needs Improvement" } }
)
```

---

## 8. DELETE

### Delete one document

```js
db.students.deleteOne({ name: "Tomy" })
```

### Delete many documents

```js
db.students.deleteMany({ score: { $lt: 84 } })
```

### Delete by array value

```js
db.students.deleteMany({ classes: 208 })
```

---

## 9. ARRAY AND NUMERIC UPDATES

### Push (add value to array)

```js
db.students.updateOne(
  { name: "Carla" },
  { $push: { classes: 333 } }
)
```

### Add to set (avoid duplicates)

```js
db.students.updateOne(
  { name: "Carla" },
  { $addToSet: { classes: 333 } }
)
```

### Increase numeric value

```js
db.students.updateOne(
  { name: "Aaron" },
  { $inc: { score: 2 } }
)
```

### Decrease numeric value

```js
db.students.updateOne(
  { name: "Aaron" },
  { $inc: { score: -2 } }
)
```

---

## 10. NESTED FIELD QUERIES

### Find nested field value (e.g., `awards.wins`)

```js
db.movies.find({ "awards.wins": 1 }).limit(2)
```

### Nested query with projection

```js
db.movies.find(
  { "awards.wins": 1 },
  { title: 1, awards: 1, _id: 0 }
).limit(2)
```

---

## 11. COUNTING

### Count documents matching a filter

```js
db.airbnb.find({ amenities: "Kitchen" }).count()
```

### Count with filter example

```js
db.airbnb.find({ "address.country": "Canada", bed_type: "Futon" }).count()
```

---

## 12. AGGREGATION AND GROUPING

### Group by a field (simple)

```js
db.students.aggregate([
  { $group: { _id: "$age" } }
])
```

### Group and calculate total score

```js
db.students.aggregate([
  { $group: { _id: "$age", total_score: { $sum: "$score" } } }
])
```

### Group and calculate average score

```js
db.students.aggregate([
  { $group: { _id: "$age", avg_score: { $avg: "$score" } } }
])
```

### Count items per group

```js
db.students.aggregate([
  { $group: { _id: "$age", count_items: { $sum: 1 } } }
])
```

### Average with addition

```js
db.students.aggregate([
  { $group: { _id: "$age", avg_score: { $avg: { $add: ["$score", 2] } } } }
])
```

### Match + Group + Sort example

```js
db.students.aggregate([
  { $match: { score: { $gte: 80 } } },
  { $group: { _id: "$age", total_score: { $sum: "$score" } } },
  { $sort: { total_score: -1 } }
])
```

---
