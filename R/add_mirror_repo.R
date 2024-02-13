#' Sets up a secondary git remote to push to
#' 
#' This function looks at a current git repository, and sets up two push 
#' remotes, as origin, to push to.  First push remote is the original origin and
#' second is a new, mirrored git repo.  The new repo serves as a mirror of the
#' original and is set up as a bare repo.  Because it is a bare repo you wont be 
#' able to browse the files and folders in the mirror location.  A clone of this 
#' repo will however restore the files and folders at the time of the last push.
#' 
#' @param mirror_repo The repository that will serve as the mirror.  Maybe a 
#'                    GitHub repo URL or a local file path.  If a local file 
#'                    path, it must not already exist.  Do not use the .git 
#'                    extension
#' @param current_repo The repo you wish to mirror.  Default is to use the current
#'                     folder.  It must be a git repository.
#' @param overwrite Logical to determine if existing mirror repository should be 
#'                  removed and replaced with the current local repo.  Default is
#'                  FALSE.  TRUE will delete the exisiting mirrored repo but wont make any
#'                  changes to the local repo.
#'                     
#' @export
#' @examples
#' \dontrun{
#' library(epar)
#' mirror <- one_drive_mirror("projects")
#' add_mirror_repo(mirror) 
#' }                    
add_mirror_repo <- function(mirror_repo, 
                            current_repo = ".", overwrite = FALSE){
  
  if(!grepl("https://", mirror_repo)){
    if(dir.exists(mirror_repo) & !overwrite){
      stop(paste("The mirror_repo,", 
                 mirror_repo, "already exists and overwrite = FALSE.  Choose a new name."))
    } else if(dir.exists(mirror_repo) & overwrite){
      fs::dir_delete(mirror_repo)
    }
  }
  
  if(!is_git()){
    stop(paste("The current_repo,", current_repo, "is not a git repo."))
  }
  
  system(paste0("git clone --bare ", current_repo, ' "', mirror_repo, '"'), 
         ignore.stdout = TRUE, 
         ignore.stderr = TRUE)
  
  current_remotes <- system("git remote -v", intern = TRUE)
  current_remotes <- stringr::str_remove(current_remotes, "origin\t")
  current_remotes <- stringr::str_remove(current_remotes, "\\s\\([a-z]+\\)")
  if(length(current_remotes)==0){
    stop("There are no current remotes set for this repo.  Please set a legit remote.")
  }
  
  if(length(current_remotes) < 3){
    remo <- unique(current_remotes)
    system(paste0('git remote set-url --add --push origin "', remo, '"'),
           ignore.stdout = TRUE, 
           ignore.stderr = TRUE)
    system(paste0('git remote set-url --add --push origin "', mirror_repo, '"'), 
           ignore.stdout = TRUE, 
           ignore.stderr = TRUE)
  } else if(length(current_remotes) >= 3){
    system(paste0('git remote set-url --add --push origin "', mirror_repo, '"'), 
           ignore.stdout = TRUE, 
           ignore.stderr = TRUE)
  }
  invisible(mirror_repo)
}

#' Set up path for a OneDrive remote
#' 
#' This function creates a path for the mirror on a users OneDrive.  Default 
#' location is the root of the users one drive and the name of the mirror defaults
#' to the name of current repository.  
#' 
#' @param repo_path Path on OneDrive to store your mirrored repository.  Defaults
#'                  to the root of your OneDrive.
#' 
#' @param repo_name Name of the mirrored repo.  Defaults to the name of the current
#'                  git repo.  Should maintain default in most cases.
#' @export
one_drive_mirror <- function(repo_path = "", repo_name = basename(getwd())){
  od_path <- normalizePath("~")
  od_path <- gsub("(Profile\\\\Documents)", "", od_path)
  if(nchar(repo_path)>0){
    repo_path <- paste0(dirname(repo_path), "/", basename(repo_path), "/")
  }
  mirror_path <- normalizePath(paste0(od_path, repo_path, repo_name), mustWork = FALSE)
  mirror_path
}

#' Is this a git repo
#' 
#' Function that returns TRUE or FALSE if the specified folder is a git repo or not.
#' 
#' @param repo Path to the folder to test if it is or is not a git repository.
#' @export
is_git <- function(repo = "."){
  gitty <- system(paste0("git -C ", repo, " rev-parse"), ignore.stdout = TRUE, 
                  ignore.stderr = TRUE)
  gitty == 0
}  