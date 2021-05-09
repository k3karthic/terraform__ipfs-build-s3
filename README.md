# Terraform - Google Cloud Build for go-ipfs

Terraform script to create a Google Cloud Build trigger for automated builds of [k3karthic/go-ipfs](https://github.com/k3karthic/go-ipfs) with [go-ds-s3](https://github.com/ipfs/go-ds-s3) plugin.

The [k3karthic](https://github.com/k3karthic/go-ipfs/tree/k3karthic) branch contains a [Dockerfile](https://github.com/k3karthic/go-ipfs/blob/k3karthic/k3karthic/Dockerfile) which builds the ipfs binary using Ubuntu 20.04 as the base.

The build pipeline in this repo uses the above Dockerfile to build the binary and stores it in a Google Cloud Storage bucket.

## Requirements

* Enable the Cloud Build API from the [Settings screen](https://console.cloud.google.com/cloud-build/settings/service-account).
* Connect to GitHub from the [Manage Repositories screen](https://console.cloud.google.com/cloud-build/repos) and add [k3karthic/go-ipfs](https://github.com/k3karthic/go-ipfs) repository.

## Input Variables

* **gcs_name** - Name of the Google storage bucket which will store the built ipfs binary.
* **gcs_location** - [GCS location](https://cloud.google.com/storage/docs/locations) of the bucket.
* **gcs_storage_class** - Storage class for the bucket.

## Deployment

### Step 1

Create a Terraform plan by running plan.sh; the script will read input variables from the file uscentral.tfvars

```
./bin/plan.sh
```

To avoid fetching the latest state of resources, run the following command.

```
./bin/plan.sh --refresh=false
```

### Step 2

Review the generated plan

```
./bin/view.sh
```

### Step 3

Run the verified plan

```
./bin/apply.sh
```

## Encryption

Sensitive files like the Terraform state files are encrypted before being stored in the repository.

You must add the unencrypted file paths to `.gitignore`.

Use the following command to decrypt the files after cloning the repository,

```
./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
./bin/encrypt.sh <gpg key id>
```
