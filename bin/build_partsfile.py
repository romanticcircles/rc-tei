"""
    build_partsfile.py
"""
import argparse

from os import listdir, getcwd, path
from xml.dom import minidom

parser = argparse.ArgumentParser("build_partsfile")
parser.add_argument("path", help="Path to directory")

def validatePath(p):
    """Validate that the path supplied to the script is a valid directory path"""
    if not path.exists(p):
        raise Exception("Path does not exist")
    elif not path.isdir(p):
        raise Exception("Path is not a directory")

def getPath():
    """Get the absolute path from command line arguments"""
    args = parser.parse_args()
    if not args.path:
        raise Exception("No path specified")
    cwd = getcwd()
    absPath = path.abspath(path.join(cwd, args.path))
    return absPath

def getXMLFiles(d):
    """Get a list of all XML files in the directory"""
    fns = [fn for fn in listdir(d) if fn.endswith('.xml')]
    if len(fns) == 0:
        raise Exception("No XML files in directory")
    return fns

def buildPartsFile(fns):
    """Build an XML parts file"""
    doc = minidom.Document()

    edition = doc.createElement("Edition")
    edition.setAttribute("xmlns:tei", "http://www.tei-c.org/ns/1.0")

    for fn in fns:
        part = doc.createElement("part")
        part.setAttribute("code", fn)
        edition.appendChild(part)
    
    doc.appendChild(edition)
    xmlStr = doc.toprettyxml(indent="\t", encoding='UTF-8')
    return xmlStr
    

def main():
    dirPath = getPath()
    validatePath(dirPath)
    xmlFiles = getXMLFiles(dirPath)
    partsFile = buildPartsFile(xmlFiles)

    outFn = 'parts.xml'
    outFile = path.join(dirPath, outFn)
    with open(outFile, 'wb') as f:
        f.write(partsFile)
        print("Created {}".format(outFile))

if __name__ == "__main__":
    main()