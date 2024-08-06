## Sameple App 
I create a simple “Hello World” web application using FastAPI, and then Dockerize it.

### Test on local 
Make the script executable by running chmod +x run.sh.
```sh
 π ~/workspcace/opt ❯ ./run.sh
```
### Test

After running the script, your FastAPI application should be running in a Docker container and accessible at http://localhost:8080. 
we can test it by using curl:
```sh
curl http://localhost:8080/
```
You should see the following response:
```sh

```