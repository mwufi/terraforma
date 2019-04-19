
# Getting VMs really fast 🔥🔥

One of the most time-consuming things about starting a new project is going from an idea to a working prototype which runs on a real computer. This repository automates that process, making it really easy to get a sandbox online!

### Using Google Cloud Platform + Terraform

Helpful links:

* https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform Read this to understand how to set up your Google Cloud credentials!

* https://towardsdatascience.com/seamlessly-integrated-deep-learning-environment-with-terraform-google-cloud-gitlab-and-docker-faee4b351e94 Read this to understand how to set up a different type of machine (GPU-enabled, also on Docker)

Now, you might want different types of machines for different things: deploying a Flask app, getting an environment to play with a Github implementation of a research paper, etc. Please let me know what you want to see!

# Overview

You have to install Terraform.

First, `terraform init`. Sets up all your resources.

To set up or change your cloud stack:

1. `terraform plan` tells you what your plan (`main.tf`) looks like, in terms of building/deleting stuff 
2. `terraform apply` tells Google Cloud that WE WANT THOSE RESOURCES! 

Now, you can SSH to your machine, do whatever you want, etc

`terraform destroy` leaves no trace of your compute environment. You're clean!

# fAQ

**Q: It didn't work!**

Yeah, that happens. Does your Google Cloud account have the right permissions? (more details about how to enable the right APIs)

**Q: I want to set up different computers.**

`main.tf` specifies the resources that you have. Change the VM

**Q: Where'd you get the image from?**

Image name: https://cloud.google.com/deep-learning-vm/docs/cli

`gcloud compute images list --project deeplearning-platform-release`

Machine types: https://cloud.google.com/compute/docs/machine-types

# The grass on the other side

Armed with the spells of Terraforma, you gaze confidently on the land of your ancestors. Computers are no longer things that you have to fight with, slogging through hours of navigating the setup pages, typing in commands to SSH to your server, making sure you have the right quotas, etc. Instead, you can simply think:

> I want a machine *that can run this code*.

Et voila, it appears, and you SSH into it, happy with the magical provision.
