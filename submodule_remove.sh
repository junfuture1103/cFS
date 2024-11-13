for dir in apps/ci_lab apps/sch_lab apps/to_lab cfe osal; do
    git add .gitmodules
    git rm --cached $dir
    rm -rf .git/modules/$dir
    rm -f $dir/.git
    git add $dir
done
git commit -m "모든 Submodule을 일반 디렉토리로 변환 및 오류 수정"
git push


