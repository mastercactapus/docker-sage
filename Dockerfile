from ubuntu:14.04

run apt-get update && apt-get install -y software-properties-common
run apt-add-repository -y ppa:aims/sagemath
run apt-get update && apt-get install -y sagemath-upstream-binary

run useradd -mU sage
user sage
env HOME /home/sage

run mkdir -p /home/sage/.sage
workdir /home/sage/.sage
run sage -c "from sagenb.notebook.notebook import load_notebook; nb = load_notebook('sage_notebook.sagenb'); um = nb.user_manager(); um.create_default_users('default'); nb.save()"

expose 8080
cmd sage -c "notebook(interface='', automatic_login=False, accounts=True)"

