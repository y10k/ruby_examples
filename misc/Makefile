run: io_fsync io_fdatasync
	time ./io_fsync
	@echo
	time ./io_fdatasync

clean:
	rm -f io_fsync io_fdatasync
	rm -f test_fsync.data test_fdatasync.data

io_fsync: io_sync.c
	$(CC) -DFSYNC=fsync -DFSYNC_S=\"fsync\" -o io_fsync io_sync.c

io_fdatasync: io_sync.c
	$(CC) -DFSYNC=fdatasync -DFSYNC_S=\"fdatasync\" -o io_fdatasync io_sync.c
