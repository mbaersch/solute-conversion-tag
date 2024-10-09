# Solute Conversion Tracking

**Custom Tag Template for Google Tag Manager**

Track landingpages and conversions for Solute (solute.de).   

[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-published-green)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/solute-conversion-tag) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/solute-conversion-tag) ![License](https://img.shelds.io/github/license/mbaersch/solute-conversion-tag)

This template is an alternative to using Custom HTML tags for [Solute Conversion Tracking](https://www.solute.de/eng/support/shopsystems/conversiontracking/) deployment. Can be used in a GTM container without access to Custom HTML tags ([restricted tag types](https://developers.google.com/tag-platform/tag-manager/restrict)).  

## Tracking landingpages 
Add the template to your container, create a new *Solute Conversion Tracking* tag with the default tag tape *Landingpage* and trigger it when there is consent for Solute Tracking. You can either fire the tag on every page or only if a `soluteclid` parameter is present. The tag will store the parameter value to *localStorage* whenever it is fired and the parameter is present in the current URL.

## Track conversions
You can create an additional tag for every conversion that you want to measure (typically a purchase). Switch the tag type to *Conversion*, add variables for *Value* and *Order ID* and keep the default *Factor* of 1 or use a variable for a dynamic value. This tag can be fired with every conversion event when consent was granted.      

