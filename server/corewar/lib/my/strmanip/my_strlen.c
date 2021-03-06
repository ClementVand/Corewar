/*
** EPITECH PROJECT, 2021
** my_strlen
** File description:
** count number of characters in a string
*/

#include <stdlib.h>

int my_strlen(char const *str)
{
    int len = 0;

    while (*str) {
        ++len;
        ++str;
    }
    return len;
}
