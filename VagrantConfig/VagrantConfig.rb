VagrantConfig = {
  box: {
    box_name: "Vagrant",
    box_number: 0,
    base_box: "ubuntu/trusty64",
    cpus: 1,
    memory: 512,
  },
  system: {
    extra_packages: [
      "htop",
      "vim",
    ],
    timezone: "Europe/London",
  },
  sync: {
    from: ".",
    to: "/var/www/vagrant",
    method: :nfs,
  },
  apache: {
    server_name: "local.canvas",
    document_root: "/var/www/vagrant",
    modules: [
      "expires",
      "headers",
      "rewrite",
    ],
  },
  mysql: {
    root_password: "root",
    database_name: "vagrant",
  },
  php: {
    extra_packages: [
      "php-pear",
      "php5-cli",
      "php5-curl",
      "php5-dev",
      "php5-gd",
      "php5-mysql",
      "php5-xdebug",
    ],
  }
}
