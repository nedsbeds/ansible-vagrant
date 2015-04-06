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
    local_document_root: ".",
    remote_document_root: "/var/www/vagrant",
    modules: [
      "expires",
      "headers",
      "rewrite",
    ],
  },
}
