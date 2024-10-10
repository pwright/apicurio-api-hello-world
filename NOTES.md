 kubectl get svc
NAME                        TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)          AGE
apicurio-registry           LoadBalancer   10.109.84.36    10.109.84.36   8080:30346/TCP   108s

  - title: Populate the Registry
    commands:
      apicurio:
        - run: curl -X POST -H "Content-type: application/json; artifactType=AVRO" -H "X-Registry-ArtifactId: share-price" --data '{"type":"record","name":"price","namespace":"com.example","fields":[{"name":"symbol","type":"string"},{"name":"price","type":"string"}]}' http://localhost:8080/apis/registry/v2/groups/my-group/artifacts


  - title: Populate the Registry
    commands:
      apicurio:
        - run: 'curl -X POST -H "Content-type: application/json; artifactType=AVRO" -H "X-Registry-ArtifactId: share-price" --data ''{"type":"record","name":"price","namespace":"com.example","fields":[{"name":"symbol","type":"string"},{"name":"price","type":"string"}]}'' http://localhost:8080/apis/registry/v2/groups/my-group/artifacts'
          apply: readme
        - run: ./populate.sh
          apply: test
