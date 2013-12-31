# this file moves selected files to newly created .dotfile folder and creates symbolic synblinks.
         
# STEPS:.

# 1. create and array of with .dotfiles elements.
# 2. create a new directory .dotfiles if this directory does not exits.
# 3. move selected .dotfiles from step 1 into directory created in step 2.
# 4. create symbolic links for all .dotfiles from step 1.
# 5. initialize a git repo.
                          
# 1. declare an array with .dotfiles element for versioning:.

declare -a Dotfiles=('bash_profile' 'bashrc' 'gitconfig' 'gitignore' 'profile' 'vimrc' 'vimrc.after' )
                              
# inform the user and print the whole array on the screen:
echo 'going to move the following selected .dotfiles:'
echo ${Dotfiles[@]}
                                    
# 2. create a variable for new directory for storing dotfiles..
dir=~/dotfiles
cd ~ && mkdir -p $dir
echo 'directory created'
                                            
# move selected dotfiles to new directory .dotfiles
                                              
for dotfile in "${Dotfiles[@]}";do
echo "moving $dotfile into directory $dir"
 mv ~/.$dotfile $dir
 echo "creating symblik for $dotfile"
 ln -s $dir/$dotfile ~/.$dotfile
 done
 echo 'done'
 done
