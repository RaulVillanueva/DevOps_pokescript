#!usr/bin/bash

if [[ ! -n $1 ]];
then
        echo "No ingreso parametro"
else
        poke=$1

        response=$(curl --write-out '%{http_code}' --silent --output /dev/null https://pokeapi.co/api/v2/pokemon/$poke)

        while [ "$response" -ne 200 ];
        do
                echo "Nombre de pokemon incorrecto, ingrese de nuevo:"
                read poke
                response=$(curl --write-out '%{http_code}' --silent --output /dev/null https://pokeapi.co/api/v2/pokemon/$poke)
        done

        output=$(curl https://pokeapi.co/api/v2/pokemon/$poke)

        id=$(echo $output | jq '.id')
        name=$(echo $output | jq -r '.name')
        weight=$(echo $output | jq '.weight')
        height=$(echo $output | jq '.height')
        order=$(echo $output | jq '.order')

        echo "id=$id, name=$name, weight=$weight, height=$height, order=$order"
fi

