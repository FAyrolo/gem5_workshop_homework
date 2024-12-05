######
#Run this inside the workloads/array_sum folder


#if [ "$#" -ne 1 ]; then
#    echo "Insert name of workload to run"
#fi

echo > temp_results
echo > temp_csv


for w in naive chunking res-race-opt chunking-res-race-opt block-race-opt all-opt; do
    echo "workload: $w"
    echo $w >> temp_csv
    for i in 1 2 4 6 8 10 12; do
        echo "$i.0" >> temp_results;
        for j in {1..100}; do
            ./$w-native 32768 $i | grep -i time >> temp_results;
        done;
        grep -oP '\d+\.\d+' temp_results | paste -sd, - >> temp_csv;
        echo > temp_results;
    done;
done;

#sed 's/\./,/g' temp_results > results_$1
#mv temp_csv results_$1
mv temp_csv all_results
rm temp_results
