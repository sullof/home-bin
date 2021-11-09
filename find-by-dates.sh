#!/bin/bash

#!/bin/bash
for i in $(find $1/ -newermt "$2" ! -newermt "$3"); do
  echo $i
done
