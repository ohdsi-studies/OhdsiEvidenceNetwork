##=========== START OF INPUTS ==========
# The zip file created in the codeToRun.R. Copy the entire path after the phrase 
# "Final results are now available in: " in the console.    
zipFileName <- "[location of the zip file: e.g. /Documents/synthea/20220329/DbProfileResults.zip]"
# For uploading the results. You should have received the key file from the study coordinator:
keyFileName <- "[location where you are storing: e.g. ~/keys/study-data-site-covid19.dat]"
##=========== END OF INPUTS ==========

##################################
# DO NOT MODIFY BELOW THIS POINT
##################################
userName <- "data-site-datadiag"

OhdsiSharing::sftpUploadFile(
  privateKeyFileName = keyFileName, 
  userName = userName,
  remoteFolder = "/",
  fileName = zipFileName
)
