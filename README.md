# ImGonnaLetItShine / GameLibraryBackend

> API backend for the Game Library app

## Endopoints

> TODO create swagger file

### GET /games/

#### query params
- page
- per_page

#### returns

```json
{
    "games": [
        {
            "id": "string",
            "title": "string",
            "truncatedDescription": "string"
        }
    ]
}
```

### GET /games/:id

#### positional params
- id

#### returns
```json
{
    "game": {
        "id": "string",
        "title": "string",
        "description": "string",
        "categories": "string[]",
        "minAge": ["number", "null"],
        "maxAge": ["number", "null"],
        "minDuration": ["number", "null"],
        "maxDuration": ["number", "null"],
    }
}
```

### GET /games/search

#### query params
- search_term
- categories
- min_age
- max_age
- min_duration
- max_duration
- give_random
- count

#### returns

```json
{
    "games": [
        {
            "id": "string",
            "title": "string",
            "truncatedDescription": "string"
        }
    ]
}
```

### POST /games/

#### body params

- title
- description
- categories
- min_age
- max_age
- min_duration
- max_duration
