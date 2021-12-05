# Terraform — Google Cloud Build for go-ipfs

Automated builds of the go-ipfs fork below using a [Google Cloud Build](https://cloud.google.com/build) trigger.
* go-ipfs
	* GitHub: [github.com/k3karthic/go-ipfs](https://github.com/k3karthic/go-ipfs)
	* Codeberg: [codeberg.org/k3karthic/bash-updater](https://codeberg.org/k3karthic/bash-updater)

The build pipeline uses a Dockerfile in the fork to build the binary and store it in a Google Cloud Storage bucket.

## Code Mirrors

* GitHub: [github.com/k3karthic/terraform__ipfs-build-s3](https://github.com/k3karthic/terraform__ipfs-build-s3/)
* Codeberg: [codeberg.org/k3karthic/terraform__ipfs-build-s3](https://codeberg.org/k3karthic/terraform__ipfs-build-s3)

## Requirements

* Enable the Cloud Build API from the [Settings screen](https://console.cloud.google.com/cloud-build/settings/service-account).
* Connect to GitHub from the [Manage Repositories screen](https://console.cloud.google.com/cloud-build/repos) and add [k3karthic/go-ipfs](https://github.com/k3karthic/go-ipfs) repository.

## Configuration

Update `ipfs.tfvars`,
* **gcs_name** — Name of the Google storage bucket which will store the built ipfs binary.
* **gcs_location** — [GCS location](https://cloud.google.com/storage/docs/locations) of the bucket.
* **gcs_storage_class** — Storage class for the bucket.

## Deployment

**Step 1:** Use the following command to create a [Terraform plan](https://www.terraform.io/docs/cli/run/index.html#planning),
```
$ ./bin/plan.sh
```

To avoid fetching the latest state of resources, use the following command,
```
$ ./bin/plan.sh -refresh=false
```

**Step 2:** Review the plan using the following command,
```
$ ./bin/view.sh
```

**Step 3:** [Apply](https://www.terraform.io/docs/cli/run/index.html#applying) the plan using the following command,
```
$ ./bin/apply.sh
```

## Encryption

Encrypt sensitive files (Terraform [input variables](https://www.terraform.io/docs/language/values/variables.html) and [state](https://www.terraform.io/docs/language/state/index.html)) before saving them. `.gitignore` must contain the unencrypted file paths.

Use the following command to decrypt the files after cloning the repository,
```
$ ./bin/decrypt.sh
```

Use the following command after running `bin/apply.sh` to encrypt the updated state files,
```
$ ./bin/encrypt.sh <gpg key id>
```

