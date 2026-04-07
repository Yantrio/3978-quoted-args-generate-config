# opentofu/opentofu#3978: genconfig doesn't quote map keys containing dots

Reproducer for [opentofu/opentofu#3978](https://github.com/opentofu/opentofu/issues/3978).

When generating configuration via `tofu plan -generate-config-out`, map key identifiers that are not valid HCL identifiers (e.g. containing dots) are emitted unquoted, producing invalid HCL.

## Steps to reproduce

1. Initialize the project:

```sh
tofu init
```

2. Run plan with config generation:

```sh
TFCOREMOCK_DYNAMIC_RESOURCES_FILE=dynamic_resources.json tofu plan -generate-config-out=generated.tf
```

3. Observe the generated `generated.tf` — the `dotted.key` map key is unquoted:

```hcl
resource "tfcoremock_dotted" "example" {
  tags = {
    dotted.key = {
      value = "should be quoted"
    }
    normal_key = {
      value = "works fine"
    }
  }
}
```

## Expected behavior

Map keys that aren't valid HCL identifiers should be quoted:

```hcl
resource "tfcoremock_dotted" "example" {
  tags = {
    "dotted.key" = {
      value = "should be quoted"
    }
    normal_key = {
      value = "works fine"
    }
  }
}
```
