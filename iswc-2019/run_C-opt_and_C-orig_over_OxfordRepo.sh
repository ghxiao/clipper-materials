########################## READ ME #######################################################################
#	This script runs both versions (C-orig) and (C-opt) over the selected ontologies from Oxford Repo 
#	as per criteria explained in the paper. It outputs the indicator if the TBox saturation for each 
#	version is computed before the time-out of 2 minutes is reached.
#	Note:
#		All ontologies are compressed in zip archive in order to conserv space. 
#		The script unzippes computes then deletes the uncompressed file
##########################################################################################################

  cd OxfordRepo
 
 #delete old results
  rm results.output
  
  #for each set of facts
  for ontology in *.zip
  do
  
    echo $ontology >> results.output
    
    #unzip the file
    unzip $ontology
    
    #run tbox saturation for the optimised version (C-opt)
    timeout 120 java -jar ../clipper.jar testOptimisation -x "${ontology%.*}".owl && echo "C-opt succeded" >>results.output || echo "C-opt failed" >>results.output

    #run tbox saturation for the original version (C-orig)
    timeout 120 java -jar ../clipper.jar testOptimisation "${ontology%.*}".owl && echo "C-orig succeded" >>results.output || echo "C-orig failed" >>results.output

    #remove the unziped file
    rm *.owl
    
  done