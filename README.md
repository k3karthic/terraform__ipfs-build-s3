# Terraform - Google Cloud Build for go-ipfs

Terraform script to create a Google Cloud Build trigger for automated builds of [k3karthic/go-ipfs](https://github.com/k3karthic/go-ipfs) with ipfs-ds-s3 plugin

The final ipfs binary is available at [https://storage.googleapis.com/go-ipfs-s3/ipfs](https://storage.googleapis.com/go-ipfs-s3/ipfs)

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
