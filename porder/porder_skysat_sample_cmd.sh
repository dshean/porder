#! /bin/bash

#Preliminary workflow for patna_20181215 SkySat Scene stereo samples
#1/3/19

#Use explorer to identify ID list
#idlist=ids_20181215.txt
idlist=sanjose_20180829_skysat_id_list.txt

#Convert to single ID on each line
~/src/porder/porder/prep_idlist.sh $idlist

idlist=${idlist%.*}_fmt.txt

#Split into batches of 100
porder idsplit --idlist $idlist --lines 100 --local ${idlist%.*}_split

#Place the order
#Note, can only have 2 active orders at a time
cd ${idlist%.*}_split
for i in *csv ; do porder order --name ${idlist%.*}_order --idlist $i --item SkySatScene --asset basic_panchromatic_dn --op email; done

#Want to grab urls from output of above commands

#Hardcode here
urls='https://api.planet.com/compute/ops/orders/v2/7c02ff24-7a3e-4325-bd7c-d28e9a9a10ae \
    https://api.planet.com/compute/ops/orders/v2/ec1896b4-8bd5-49a4-a5f0-123c10303933 \
    https://api.planet.com/compute/ops/orders/v2/363dd232-bdc6-4701-ba66-6e57041b99d5 \
    https://api.planet.com/compute/ops/orders/v2/63454449-4214-44c8-bf31-fb11de7768a9'

urls='https://api.planet.com/compute/ops/orders/v2/027a3f44-56a3-4019-8ffc-99a817d66b3b \
    https://api.planet.com/compute/ops/orders/v2/dcb9503e-9297-4db7-9d0d-099bd07072bc \
    https://api.planet.com/compute/ops/orders/v2/1a4100ef-b50e-45a9-89ef-3857273e8cb1 \
    https://api.planet.com/compute/ops/orders/v2/fbd9a159-3dc8-4b8a-8ef1-fefcb0b24539 \ 
    https://api.planet.com/compute/ops/orders/v2/1c63f68d-c1cb-443c-a120-638b546965a2 \
    https://api.planet.com/compute/ops/orders/v2/56a071b0-e611-4523-bc65-b68f178c69bb \
    https://api.planet.com/compute/ops/orders/v2/67347570-c56a-46f2-9bf9-b2cbb519e8c4 \
    https://api.planet.com/compute/ops/orders/v2/2b6f0d50-0b28-4d8a-a9e6-4b701ba40d60 \
    https://api.planet.com/compute/ops/orders/v2/90ec2869-1035-4c17-b1e0-7be5994bbbf2'

#Check status to make sure ready for download

#Download order
#parallel --delay 1.0 'echo $url; porder multipart --url {} --local dl --errorlog dl/error.log' ::: $urls
#for url in $urls ; do porder multipart --url $url --local dl --errorlog dl/error.log ; done
mkdir dl
for url in $urls ; do porder download --url $url --local dl --errorlog dl/error.log ; done

#Prepare for sharing
#tar -czvf patna_20181215_ssc_stereo.tar.gz dl
#gdrive upload patna_20181215_ssc_stereo.tar.gz
