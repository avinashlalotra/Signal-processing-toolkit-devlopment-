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
#move(os.getcwd(),"/home/avinash/Desktop/FOSSEE-Signal-Processing-Toolbox/macros")
def rename_svg(sr_dir):
    for folder in os.listdir(sr_dir):
        try:
            i=0
            for file in os.listdir(os.path.join(sr_dir,folder)):
                i+=1
                if file[-4:] == ".svg" :
                    os.rename(os.path.join(sr_dir,folder,file),os.path.join(sr_dir,folder,folder+"testcase"+str(i)+".svg"))
                    print("{file} renamed sucessfuly")
            print(f"{folder} is processed succesfully")
        except Exception as e :
            print(f"{folder} - Unexpected error: {e}")
rename_svg(os.getcwd())            