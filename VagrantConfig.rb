VagrantConfig = {
  box: {
    box_name: "Canvas",
    box_number: 10,
  },
  system: {
    extra_packages: [
      "htop",
      "vim",
    ],
    timezone: "Europe/London",
  },
  apache: {
    server_name: "local.canvas",
    local_document_root: ".",
    remote_document_root: "/var/www/vagrant",
    modules: [
      "expires",
      "headers",
      "rewrite",
    ],
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
