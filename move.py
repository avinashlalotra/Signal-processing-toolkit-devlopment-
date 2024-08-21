import os
import shutil
# Move files from subfolder to a designated folder for PR
def move(sr_dir,dest_dir):
    for folder in os.listdir(sr_dir):
        try:
            shutil.copy(os.path.join(sr_dir,folder,folder+".md"),os.path.join(dest_dir,folder+".md"))
            print( f" {folder}.md succesfully copied")
        except Exception as e:
            print(f"{folder} - Unexpected error: {e}")    
move(os.getcwd(),"/home/avinash/Desktop/FOSSEE-Signal-Processing-Toolbox/macros")