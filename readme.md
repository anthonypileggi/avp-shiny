
Introduction
------------

Welcome to my Shiny Server! This repo contains everything needed to deploy a Shiny Server on Google Cloud.

Check out my app [portfolio](https://blog.sqwerl.life/shiny/) to see them in action!

Build Triggers
--------------

There is a [build trigger](https://console.cloud.google.com/cloud-build/triggers) setup for this repo. Every time a change is pushed, the image is rebuilt using the included Dockerfile. It's pretty great!

Deploying on Google Cloud
-------------------------

Here's the code I use to deploy a new VM with the updated image:

``` r
library(googleComputeEngineR)

vm <- gce_vm(
  "avp-shiny-master", 
  predefined_type = "g1-small", 
  template = "shiny",
  dynamic_image = gce_tag_container("shiny", project = "avp-consulting")
  )
```

Once the new VM is available, then we can switch it to the static IP and turn off the old machine.

Deployment Summary
------------------

1.  Make changes and push to Github (and trigger Cloud Build)
2.  Confirm the Cloud Build is successful
3.  Spin up a new VM with the updated build image
4.  Confirm the new VM is up and running
5.  Point the new VM to my static IP address -- [link](https://console.cloud.google.com/networking/addresses/list)
6.  Delete the old VM
