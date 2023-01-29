#!/bin/sh

a_umlaut="a%CC%88"
o_umlaut="o%CC%88"
a_overring="a%CC%8A"

k_mdi_item_cf_bundle_identifier='com.bohemiancoding.sketch3'
application_url_prefix="sketch://"

sketch_tool_path=$(mdfind kMDItemCFBundleIdentifier==$k_mdi_item_cf_bundle_identifier | head -n 1)
sketch_tool="$sketch_tool_path/Contents/MacOS/sketchtool"

# Get path to document
# TODO: path to plugin bundle
$sketch_tool run --without-activating ~/Library/Application\ Support/com.bohemiancoding.sketch3/Plugins/automate-sketch.sketchplugin copy_document_url
document_url=$(pbpaste)
# Remove application url
document_path=${document_url#"$application_url_prefix"}
# Normalize spaces
document_path=$(echo $document_path|sed -e 's/%20/ /g')
# Finnish alphabet
document_path=$(echo $document_path|sed -e "s/$a_umlaut/ä/g")
document_path=$(echo $document_path|sed -e "s/$o_umlaut/ö/g")
document_path=$(echo $document_path|sed -e "s/$a_overring/å/g")

# Export
$sketch_tool export slices --use-id-for-name "${document_path}"
