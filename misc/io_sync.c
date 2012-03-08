#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

#ifndef FSYNC
#define FSYNC fsync
#endif

#ifndef FSYNC_S
#define FSYNC_S "fsync"
#endif

#define BLK_SIZE (1024*4)
#define BLK_COUNT 100
#define WRITE_TARGET "test_" FSYNC_S ".data"

int main()
{
  int w_fd, i;
  char block[BLK_SIZE];

  printf("block size: %d bytes\n", BLK_SIZE);
  printf("block count: %d\n", BLK_COUNT);
  printf("total write size: %d bytes\n", BLK_SIZE * BLK_COUNT);
  printf("sync system call: %s\n", FSYNC_S);
  printf("write target: %s\n", WRITE_TARGET);

  assert((w_fd = open(WRITE_TARGET, O_WRONLY | O_CREAT | O_TRUNC, 0644)) >= 0);
  for (i = 0; i < BLK_COUNT; ++i) {
    assert(write(w_fd, block, BLK_SIZE) == BLK_SIZE);
    assert(FSYNC(w_fd) >= 0);
  }
  assert(close(w_fd) >= 0);

  return 0;
}
