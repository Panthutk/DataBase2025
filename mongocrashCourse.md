# MongoDB Crash Course

## Password

oIyWdc26TslXkTj3

## List all databases

```js
db.adminCommand({ listDatabases: 1 })
```

## Create (or use existing) database

```js
use classdb
```

## Insert one document

```js
db.movies.insertOne({ name: "Jurassic Park" })
```

## Find all documents

```js
db.movies.find()
```

## Insert multiple documents

```js
db.movies.insertMany([
  { name: "Toy Story", company: "Pixar" },
  { name: "Mad Max" }
])
```

## Insert multiple students

```js
db.students.insertMany([
  { name: "Tomy", age: 17, score: 80 },
  { name: "Jane", age: 18, score: 85 },
  { name: "Sally", age: 19, score: 84 }
])
```

## Insert students with class arrays

```js
db.students.insertMany([
  { name: "Aaron", age: 17, score: 80, classes: [111, 208, 239] },
  { name: "Brian", age: 18, score: 85, classes: [111, 200, 239] },
  { name: "Carla", age: 19, score: 84, classes: [187, 208, 438] }
])
```

## Find by equality

```js
db.students.find({ name: "Sally" })
db.students.find({ score: 84 })
```

## Find documents containing a value in an array

```js
db.students.find({ classes: 111 })
```

## Find not equal

```js
db.students.find({ score: { $ne: 84 } })
```

## Find greater than or equal

```js
db.students.find({ score: { $gte: 84 } })
```

## Find greater than

```js
db.students.find({ score: { $gt: 84 } })
```

## Find lower than

```js
db.students.find({ score: { $lt: 84 } })
```

## Find lower than or equal

```js
db.students.find({ score: { $lte: 84 } })
```

## Find where value is in a list ($in)

```js
db.students.find({ name: { $in: ["Jane", "Sally"] } })
```

## Find where value is not in a list ($nin)

```js
db.students.find({ name: { $nin: ["Jane", "Sally"] } })
```

## Specified complex find condition (can use operators like $lt, $gt with $elemMatch)

```js
db.students.find({ classes: { $elemMatch: { $eq: 111 } } })
```

## Check if field exists

```js
db.students.find({ classes: { $exists: true } })
```

## Check if field does not exist

```js
db.students.find({ classes: { $exists: false } })
```
