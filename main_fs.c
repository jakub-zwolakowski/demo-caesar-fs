#include <stdlib.h>
#include <stdio.h>
#include <caesar.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

#define MAX_STR_LEN 256

void gen_test(char *str, int str_len, int shift)
{
    char *res1, *res2;

    printf("Encrypt text '%s'\n", str);
    res1 = caesar_encrypt(str, str_len, shift);
    if (!res1) return;
    printf("Result:       %s\n", res1);

    printf("Decrypt text '%s'\n", res1);
    res2 = caesar_decrypt(res1, str_len, shift);
    if (!res2) return;
    printf("Result:       %s\n", res2);

    free(res1);
    free(res2);
}

int main(void)
{
    check_magic_number();

    int shift;
    FILE *fid_shift = fopen("shift.in", "r");
    if (fid_shift == NULL) return 1;
    if (fread(&shift, sizeof(int), 1, fid_shift) != 1) return 2;
    fclose(fid_shift);

    char str[MAX_STR_LEN];
    memset(str, 0, sizeof str);
    FILE *fid_text = fopen("text.in", "r");
    if (fid_text == NULL) return 1;
    int i = 0;
    while ( i < MAX_STR_LEN ) {
      char c = fgetc(fid_text);
      if ( c == '\n' || c == EOF )
        break;
      str[i] = c;
      i++;
    }
    fclose(fid_text);

    int str_len = i + 1;

    gen_test(str, str_len, shift);

    return 0;
}
