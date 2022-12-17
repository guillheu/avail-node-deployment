## Avail node deployment

This repo aims at facillitating the deployment and updating of Polygon avail nodes.

### Warning
This repo is very much a **WORK IN PROGRESS** and is not meant to be used in production without review, modifications or audits.<br>
Basic knowledge of Ansible is necessary to configure this repo. Knowledge of Docker and docker-compose is recommended.

### Repo structure
 * `ansible` folder : contains playbooks, inventories and variables to use ansible with to set up an avail node. This is most likely what you're interested in.
 * `docker` folder : contains a dockerfile and a compose file to setup a "dev" environment to deploy an avail node to. **THIS SHOULD NOT BE USED FOR PRODUCTION**
 * `nomad-testing` : submodule for development of this repo.
 * `avail` : submodule containing the avail-node sources. Not directly used by the ansible playbook and serves as reference only.

### How to use
 1. Configure the [`ansible/configs/inventory.yaml` inventory file](/ansible/configs/inventory.yaml) with your node host or hosts
    Note: The "dev" group contains a single host that should map to the dev host bootstrapped by the docker-compose file. Do not modify that group or its host.
 2. Modify the [`ansible/configs/node_variables.yaml` file](/ansible/configs/node_variables.yaml) to configure  your node
 3. Configure the playbooks in [`ansible/playbooks/`](/ansible/playbooks/) to use the hosts and groups you just defined in the inventory file
 4. Run the ansible playbook.

### TODO
 * Add support for importing controller key