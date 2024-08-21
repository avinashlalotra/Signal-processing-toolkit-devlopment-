import os
# # version 1
# Sr_dir = os.getcwd()
# folders = os.listdir(Sr_dir)
# for folder in folders :
#     files = os.listdir(os.path.join(Sr_dir,folder))
#     for file in files:
#         if file == "readme.md" :
#             os.rename(os.path.join(Sr_dir,folder,file),os.path.join(Sr_dir,folder,folder+".md"))
#             print(f"{folder} done")
# version 2
def rename_readme(Sr_dir):
    for folder in os.listdir(Sr_dir):
        try:
            old_name=os.path.join(Sr_dir,folder,"readme.md")
            new_name= os.path.join(Sr_dir,folder,folder+".md")
            os.rename(old_name,new_name)
        except FileNotFoundError:
            print(f"{folder} - readme not found")
        except PermissionError :
            print(f"{folder} - permission denied for renaming")
        except Exception as e:
            print(f"{folder} - Unexpected error: {e}")
rename_readme(os.getcwd())            
