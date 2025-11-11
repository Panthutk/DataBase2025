# activity1

## How many listings have a kitchen as an amenity?

```js
db.airbnb.find({amenities: "Kitchen"}).count()
```

## How many listings in Canada have futons as the bed type?

```js
db.airbnb.find({"address.country": "Canada",bed_type: "Futon"}).count()
```
