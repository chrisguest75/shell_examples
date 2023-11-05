#!/usr/bin/env python3
import json
import argparse
import xml.etree.ElementTree as ET

# Create an ArgumentParser object
parser = argparse.ArgumentParser(description="Process an XML file.")

# Define a command-line argument
parser.add_argument('file', type=str, help="A command-line argument.")

# Parse the command-line arguments
args = parser.parse_args()

namespace = "http://s3.amazonaws.com/doc/2006-03-01/"

# Parse the XML file
tree = ET.parse(args.file)
root = tree.getroot()
root.tag = f"{{{namespace}}}ListBucketResult"

print('uri')

# Now, when you access elements within this namespace, you need to use the full namespace URL
for content in root.findall(f".//{{{namespace}}}Contents"):
    key = content.find(f"{{{namespace}}}Key").text
    print(key)
