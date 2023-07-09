# ImGonnaLetItShine / GameLibraryBackend

> API backend for the Game Library app

## Endopoints

> TODO create swagger file

### GET /categories/

#### returns

```json
{
    "categories": [
        {
            "id": "number",
            "name": "string"
        }
    ]
}
```

### POST /categories/

#### body params

- category
  - name

### GET /games/

#### query params
- page
- per_page

#### returns

```json
{
    "games": [
        {
            "id": "number",
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
        "id": "number",
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
- q
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
            "id": "number",
            "title": "string",
            "truncatedDescription": "string"
        }
    ]
}
```

### POST /games/

#### body params
- game
  - title
  - description
  - categories
  - min_age
  - max_age
  - min_duration
  - max_duration
