import subprocess
import zipfile

# Database settings
db_user = 'wikijs'
db_name = 'wiki'
container_name = 'wiki_js_db_1'
dump_file_in_container = '/var/lib/postgresql/data/wiki_db_dump.sql'
dump_file_on_host = './wiki_db_dump.sql'
zip_file = 'wiki_db_dump.zip'

# Execute pg_dump inside the container
subprocess.run(
    ['docker', 'exec', '-u', 'postgres', container_name, 'pg_dump', '-U', db_user, '-d', db_name, '-f', dump_file_in_container],
    check=True
)

# Copy the dump file from the container to the host
subprocess.run(
    ['docker', 'cp', f'{container_name}:{dump_file_in_container}', dump_file_on_host],
    check=True
)

# Create a zip archive with the dump file
with zipfile.ZipFile(zip_file, 'w', zipfile.ZIP_DEFLATED) as zipf:
    zipf.write(dump_file_on_host)
