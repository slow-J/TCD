int n =0;
int count =0;
proctype p()
{
   int temp,i;
   for(i : 0..1){
	temp = n;
	temp = temp +1;
	n = temp;
	printf("p\n");
   }  
   count = count + 1;
}
proctype q()
{
   int i;
   for(i : 0..1){
	n = n + 1;
	printf("q\n");
   }  
   count = count + 1;
}
active proctype main()
{	
	atomic
	{

 	run p(); 
	run q();
	}
	do
	:: (count == 2) ->
		break
	od
        assert(n ==4);
}
