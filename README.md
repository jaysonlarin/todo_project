A simple application for ToDo's and add different tasks for each Todo.

Get all tasks for a Todo. (get request)
```
http://localhost:3000/todos/1/tasks.json
```

Get a task for a Todo. (get request)
```
http://localhost:3000/todos/1/tasks/1.json
```

Delete a task for a Todo. (delete request)
```
http://localhost:3000/todos/1/tasks/1.json
```

Create a task for a Todo. (post request)
```
http://localhost:3000/todos/1/tasks.json
```
with a json body
```
{
    "task": {
        "description": "hello there",
        "finished": false
    }
}
```
note:
- sequence is automatically created.
- finished default is false


Update a task for a Todo. (patch request)
```
http://localhost:3000/todos/1/tasks/1.json
```
with a json body
```
{
    "task": {
        "description": "hello there",
        "sequence": 2,
        "finished": true
    }
}
```
