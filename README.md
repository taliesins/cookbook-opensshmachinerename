opensshmachinerename Cookbook
=============================
When a machine is renamed, the passwd file will need to be updated with the new name, if it is connected to Active Directory.


Requirements
------------
#### recipes

Usage
-----
Just include `opensshmachinerename` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opensshmachinerename]"
  ]
}
```


License and Authors
-------------------
Authors: Taliesin Sisson
