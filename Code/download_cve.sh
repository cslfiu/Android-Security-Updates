#!/bin/bash

# Directory to save the files
<<<<<<< HEAD
DEST_DIR="../Data/NIST-all"
=======
DEST_DIR="./Data/NIST-all"
>>>>>>> my-new-branch
BASE_URL="https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-"
CURRENT_YEAR=$(date +"%Y")

# Create destination directory if it doesn't exist
mkdir -p $DEST_DIR

# Download, unzip, and remove the zip for recent CVEs
echo -n "Processing: nvdcve-1.1-recent.json.zip... "
curl -s -o "${DEST_DIR}/nvdcve-1.1-recent.json.zip" "${BASE_URL}recent.json.zip"
unzip -q -o "${DEST_DIR}/nvdcve-1.1-recent.json.zip" -d $DEST_DIR
rm "${DEST_DIR}/nvdcve-1.1-recent.json.zip"
echo "Done"

# Download, unzip, and remove the zip for CVEs from 2002 to the current year
for (( year=2002; year<=$CURRENT_YEAR; year++ ))
do
    FILENAME="nvdcve-1.1-${year}.json.zip"
    echo -n "Processing: $FILENAME... "
    URL="${BASE_URL}${year}.json.zip"
    DEST="${DEST_DIR}/${FILENAME}"
    curl -s -o $DEST $URL
    unzip -q -o $DEST -d $DEST_DIR
    rm $DEST
    echo "Done"
done

echo "CVE files downloaded, unzipped, and saved to $DEST_DIR"
