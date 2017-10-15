1. howto setup swagger-editor

- dowload swagger-editor-3.1.10.zip and unzip to foler on windows
- run index.html and go ahead

2. howto setup swagger-ui and load local json

- easiest way is to use docker: 

  -- docker pull swaggerapi/swagger-ui

  -- docker run -p 80:8080 -e SWAGGER_JSON=/foo/swagger.json -v /root:/foo  swaggerapi/swagger-ui
  on host, swagger.json is placed under /root/, while foo is path in docker

  -- then visit 80 port and swagger-ui will load local json



