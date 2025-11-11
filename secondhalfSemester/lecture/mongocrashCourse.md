# MongoDB Crash Course

## CRUD Operations

---

## List all databases

```js
db.adminCommand({ listDatabases: 1 })
```

## Create (or use existing) database

```js
use classdb
```

---

## Create / Insert

### Insert one document

```js
db.movies.insertOne({ name: "Jurassic Park" })
```

### Find all documents

```js
db.movies.find()
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

## Read / Find

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

### Find greater / less than or equal

```js
db.students.find({ score: { $gte: 84 } })
db.students.find({ score: { $gt: 84 } })
db.students.find({ score: { $lt: 84 } })
db.students.find({ score: { $lte: 84 } })
```

### Find where value is in or not in a list

```js
db.students.find({ name: { $in: ["Jane", "Sally"] } })
db.students.find({ name: { $nin: ["Jane", "Sally"] } })
```

### Complex find condition (can use operators like $lt, $gt with $elemMatch)

```js
db.students.find({ classes: { $elemMatch: { $eq: 111 } } })
```

### Check if field exists or not

```js
db.students.find({ classes: { $exists: true } })
db.students.find({ classes: { $exists: false } })
```

---

## Projection (Show / Hide fields)

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

## Sorting and Limiting

### Decreasing order (max to min)

```js
db.students.find(
  {},
  { score: 1, age: 1, _id: 0 }
).sort({ score: -1 })
```

### Decreasing order with limit

```js
db.students.find(
  {},
  { score: 1, age: 1, _id: 0 }
).sort({ score: -1 }).limit(4)
```

### Increasing order (min to max)

```js
db.students.find(
  {},
  { score: 1, age: 1, _id: 0 }
).sort({ score: 1 })
```

---

## Logical Conditions

### AND condition

```js
db.students.find({ age: 17, score: 90 })
```

### OR condition

```js
db.students.find({ $or: [{ age: 18 }, { score: 90 }] })
```

### Range condition (greater than X and less than Y)

```js
db.students.find({ score: { $gte: 84, $lte: 85 } })
```

---

## Update / Replace

### Replace an entire document (Dangerous — replaces everything)

```js
db.students.replaceOne({ name: "Sally" }, { score: 89 })
```

⚠️ This **removes all previous fields** like `name`, `age`, and `classes`, leaving only `{ score: 89 }`.

### Update one field safely (preserve other fields)

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

## Delete

### Delete one document

```js
db.students.deleteOne({ name: "Tomy" })
```

### Delete many documents

```js
db.students.deleteMany({ score: { $lt: 84 } })
```

### Delete documents by array value

```js
db.students.deleteMany({ classes: 208 })
```

---

## Array and Numeric Updates

### Push (add value to array)

```js
db.students.updateOne(
  { name: "Carla" },
  { $push: { classes: 333 } }
)
```

### Add to set (avoid duplicates in array)

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

## Nested Field Queries

### Find nested field value (example: `awards.wins` inside subdocument)

```js
db.movies.find({ "awards.wins": 1 }).limit(2)
```

### Nested query with specific field projection

```js
db.movies.find(
  { "awards.wins": 1 },
  { title: 1, awards: 1, _id: 0 }
).limit(2)
```
