# activity1

## How many listings have a kitchen as an amenity?

```js
db.airbnb.find({amenities: "Kitchen"}).count()
```

## How many listings in Canada have futons as the bed type?

```js
db.airbnb.find({"address.country": "Canada",bed_type: "Futon"}).count()
```

# How many listings have a host who is either a superhost or a person with response rate at least 95 (or both)?

```js
db.airbnb.find({
  $or: [
    { "host.host_is_superhost": true },
    { "host.host_response_rate": { $gte: 95 } }
  ]
}).count()
```

# Which three listings has the highest cleaning fee? List their names and their cleaning fees

```js
db.airbnb.find({}, { name: 1, cleaning_fee: 1,_id: 0 }).sort({ cleaning_fee: -1 }).limit(3)
```

# What is the average price of the listings that accommodates exactly 7 people?

```js
db.airbnb.aggregate([
  {
    $match: { accommodates: 7 }  // 
  },
  {
    $group: {
      _id: "$accommodates",
      avg_price: { $avg: "$price" }  
    }
  }
])
```

# pick your own question

### Using the airbnb collection, find the average price for each room type among listings that can accommodate at least 2 guests

```js
db.airbnb.aggregate([
  { $match: { accommodates: { $gte: 2 } } },
  {
    $group: {
      _id: "$room_type",
      avg_price: { $avg: "$price" }
    }
  },
  {
    $project: {
      _id: 1,
      avg_price: { $round: ["$avg_price", 2] }
    }
  }
])
```
