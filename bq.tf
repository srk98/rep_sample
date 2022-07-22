resource "google_bigquery_dataset" "default" {
  dataset_id                  = "mydataset0"
  friendly_name               = "test"
  description                 = "This dataset is valid"
  location                    = "US"
  default_table_expiration_ms = 3600000
  delete_contents_on_destroy  = true
  labels = {
    env = "default"
  }
  default_encryption_configuration {
    kms_key_name = google_kms_crypto_key.crypto_key.id
  }
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = "example-key1"
  key_ring = google_kms_key_ring.key_ring.id
}

resource "google_kms_key_ring" "key_ring" {
  name     = "example-keyring4"
  location = "us"
}


resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "mytable"

  schema = <<EOF
[
  {
    "name": "Student_Name",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Name of student"
  },
  {
    "name": "ID_No",
    "type": "INTEGER",
    "mode": "NULLABLE",
    "description": "Student ID"
  },
  {
    "name": "Student_Age",
    "type": "INTEGER",
    "mode": "NULLABLE",
    "description": "Age of the Student"

  }
]
EOF

}
