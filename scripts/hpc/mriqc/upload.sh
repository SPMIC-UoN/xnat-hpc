#!/gpfs01/software/imaging/miniconda3/envs/xnat/bin/python
"""
Script to upload data from a BIDS compliant MRIQC output to a known project/subject/session
"""
import sys
import os 
import tempfile

import xnat
import json

XML_HEADER = """<?xml version="1.0" encoding="UTF-8"?>
<MRIQCData xmlns="http://github.com/spmic-uon/xnat-hpc" xmlns:xnat="http://nrg.wustl.edu/xnat" xsi:schemaLocation="http://github.com/spmic-uon/xnat-hpc schema.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xnat:label>%s</xnat:label>
  <mriqcVersion>%s</mriqcVersion>"""

XML_FOOTER = """
</MRIQCData>"""

print("Upload MRIQC: %s" % sys.argv)
host_url = sys.argv[1]
proj=sys.argv[2]
subj=sys.argv[3]
exp=sys.argv[4]
bidsdir=sys.argv[5]
assessor_name=sys.argv[6]
user_alias = sys.argv[7]
jsessionid = sys.argv[8]

def bids_match(bids_name, xnat_name):
    ret = bids_name.endswith(xnat_name.replace(" ", "").replace("_", "").replace("-", ""))
    print("Match? %s : %s -> %s" % (bids_name, xnat_name, ret))
    return ret

def create_scanxml(fname, md):
    xml = "  <scan>\n"
    xml += "    <scan_id>%s</scan_id>\n" % fname[:fname.index(".")]
    for key in md:
        if key not in ("bids_meta", "provenance"):
            xml +="    <%s>%s</%s>\n" % (key, md[key], key)
    xml += "  </scan>\n"
    return xml

def upload(sesdir):
    json_files = []
    xml = XML_HEADER % (assessor_name, "unknown")
    for subdir in os.listdir(sesdir):
        print("Uploading files in %s" % subdir)
        filedir = os.path.join(sesdir, subdir)
        for fname in os.listdir(filedir):
            print("Uploading: %s" % fname)
            fpath = os.path.join(filedir, fname)
            json_files.append(fpath)
            with open(fpath) as f:
                md = json.load(f)
                xml += create_scanxml(fname, md)
    xml += XML_FOOTER

    # Create the MRIQC resource with QC data as key/value fields
    f = None
    try:
        f = tempfile.NamedTemporaryFile(suffix=".xml", delete=False)
        f.write(xml.encode("utf-8"))
        f.close()
        print(xml)
        print("xnatc --user=%s --password=%s --xnat=%s --project=%s --subject=%s --experiment=%s --create-assessor=%s" % (user_alias, jsessionid, host_url, proj, subj, exp, f.name))
        os.system("xnatc --user=%s --password=%s --xnat=%s --project=%s --subject=%s --experiment=%s --create-assessor=%s" % (user_alias, jsessionid, host_url, proj, subj, exp, f.name))
    finally:
        if f: os.unlink(f.name)

    # Also upload each individual json file as a resource
    for fpath in json_files:
        print("xnatc --user=%s --password=%s --xnat=%s --project=%s --subject=%s --experiment=%s --assessor=%s --upload=%s --upload-resource=JSON" % (user_alias, jsessionid, host_url, proj, subj, exp, assessor_name, fpath))
        os.system("xnatc --user=%s --password=%s --xnat=%s --project=%s --subject=%s --experiment=%s --assessor=%s --upload=%s --upload-resource=JSON" % (user_alias, jsessionid, host_url, proj, subj, exp, assessor_name, fpath))

# FIXME no project toplevel dir at present
#for bidsproj in os.listdir(bidsdir):
#    if bids_match(proj, bidsproj):
#        projdir = os.path.join(bidsdir, bidsproj)
projdir = bidsdir
for bidssubj in os.listdir(projdir):
    # FIXME issue with subject name vs internal XNAT subject ID
    #    if bids_match(bidssubj, subj):
    print("Checking %s" % bidssubj)
    subjdir = os.path.join(projdir, bidssubj)
    if os.path.isdir(subjdir) and bidssubj != "logs":
        print("Found subject dir: %s" % subjdir)
        for bidsses in os.listdir(subjdir):
            if bids_match(bidsses, exp):
                sesdir = os.path.join(subjdir, bidsses)
                print("Found session dir: %s" % sesdir)
                print("Uploading contents of %s" % sesdir)
                upload(sesdir)
