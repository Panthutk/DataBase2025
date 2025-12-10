
# hw1

## Q1 For listings whose bed type is not "Real Bed", how many people do they accommodate on average?

```js
db.airbnb.aggregate([
  { $match: { bed_type: { $ne: "Real Bed" } } },
  { $group: { _id: null, avgAccommodates: { $avg: "$accommodates" } } }
])
```

## Q2 How many listings have between 50 and 99 reviews (inclusive)?

``

```js
db.airbnb.count({ number_of_reviews: { $gte: 50, $lte: 99 } })
```

## Q3 How many listings have empty notes section or missing the section entirely?

```js
db.airbnb.count({
  $or: [
    { notes: "" },
    { notes: { $exists: false } }
  ]
})
```

## Q4 Find any one route that has BKK as the destination and display only the airline name, the source airport, and the destination airport

```js
db.routes.find(
  {dst_airport :"BKK"},
  {_id:0,"airline.name": 1,src_airport:1,dst_airport:1}
)
```

## Q5 Is there an IATA code that is shared by multiple airlines? If so, which IATA code and which airlines?

```js
db.routes.aggregate([
  {$group:{_id:"$airline.iata",airlines:{$addToSet:"$airline.name"}}},
  {$match:{$expr:{$gt:[{$size:"$airlines"},1]}}},
  {$project:{_id:0,IATA_Code:"$_id",Airlines:"$airlines"}}
  ])
```

## Q6 How many airlines fly only one type of airplane?

```js
db.routes.aggregate([
    { 
        $group: { 
            _id: "$airline.name", 
            unique_airplanes: { $addToSet: "$airplane" } 
        } 
    },

    { 
        $match: { 
            $expr: { $eq: [ { $size: "$unique_airplanes" }, 1 ] } 
        } 
    },
    
    { 
        $count: "airlines_with_one_airplane_type" 
    }
])
```

## Q7 From which source airport can you fly to the most destination airports?

```js
db.routes.aggregate([
  {
    $group: {
      _id: "$src_airport",
      destinations: { $addToSet: "$dst_airport" }
    }
  },

  {
    $addFields: {
      num_destinations: { $size: "$destinations" }
    }
  },

  {
    $sort: { num_destinations: -1 }
  },

  {
    $limit: 1
  },

  {
    $project: {
      _id: 0,
      Source_Airport: "$_id",
      Num_Destinations: "$num_destinations"
    }
  }
]);

```

## Which 5 airlines have the lowest percentage of non-stop routes? (The percentage is calculated against the total number of routes for each airline. If an airline only has non-stop routes, this should be 100%.)

``` js
db.routes.aggregate([
  {
    $group: {
      _id: "$airline.name",
      Total_Routes: { $sum: 1 },
      Non_Stop_Routes: {
        $sum: {
          $cond: [
            { $eq: ["$stops", 0] },   // if stops == 0 → count as non-stop
            1,
            0
          ]
        }
      }
    }
  },

  {
    $addFields: {
      Non_Stop_Percentage: {
        $multiply: [
          { $divide: ["$Non_Stop_Routes", "$Total_Routes"] },
          100
        ]
      }
    }
  },

  {
    $sort: { Non_Stop_Percentage: 1 } // sort ascending
  },

  {
    $limit: 5 // lowest 5 airlines
  },

  {
    $project: {
      _id: 0,
      Airline_Name: "$_id",
      "Non-Stop Percentage": {
        $concat: [
          { $toString: { $round: ["$Non_Stop_Percentage", 2] } },
          "%"
        ]
      }
    }
  }
]);

```
