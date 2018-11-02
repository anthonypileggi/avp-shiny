# Start up a shiny server via Build Trigger'd image

library(googleComputeEngineR)
vm <- gce_vm(
  "avp-shiny", 
  predefined_type = "f1-micro", 
  template = "shiny",
  dynamic_image = gce_tag_container("shiny", project = "avp-consulting")
  )

# reset vm (to load newest docker image??)
gce_vm_reset(vm)
