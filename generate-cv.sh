#!/bin/bash

fop -c fop.xconf -xml WebContent/xml/cv.xml -xsl WebContent/xsl/cv.xsl -pdf cv.pdf
