#define size32 int
#define fre(i,a,b) for(int i=a;i<b;i++)

size32 sum(size32 nums[],int n){
    size32 ans=0;
    for(int i=0;i<n;i++){
        ans+=nums[i];
    }
    return ans;
}

inline size32 f(size32 num,size32 n){
    num = num % 1007;
    num = num ^ n;
    return num;
}

int main(){
    size32 nums[10];
    nums[0]=1;
    nums[1]=1;
    fre(i,2,10){
        nums[i]=nums[i-1]+nums[i-2];
    }
    size32 s = 0;
    s+=sum(nums,10);
    s=f(s,10);
}