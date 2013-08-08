BUILDDIR = build
KEYDIR   = $(BUILDDIR)/keys

.PHONY:	all
all:	keys
	
.PHONY: clean
clean:
	@rm -rf $(BUILDDIR)

.PHONY:	keys
keys:	$(KEYDIR)/master.pub \
	$(KEYDIR)/nginx01.intranet.pub


%.pub:	%.pem
	openssl rsa -in $< -pubout > $@

.PRECIOUS:	%.pem
%.pem:
	mkdir -p $(dir $@)
	openssl genrsa -out $@ 2048
