<!--#include file="KISA_SHA256.asp"-->

<%

Private Const SHA256_DIGEST_VALUELEN = 32
Private Const SHA256_DIGEST_BLOCKLEN = 64

class KISA_HMAC_C
        public Function HMAC_SHA256(message, mlen, key, klen, byref hmac)
            dim ipad
            dim opad
            dim i
            dim tk(31)
            dim tb(63)
            dim macLen
            dim tmp
            dim tmplen

            macLen = SHA256_DIGEST_VALUELEN
            ipad = &H36
            opad = &H5C

            if klen > SHA256_DIGEST_BLOCKLEN then
                call SHA256_Encrypt(key, klen, tk)
                klen = SHA256_DIGEST_VALUELEN
                key = tk
            end if

            for i = 0 To klen - 1
                tb(i) = ipad xor key(i)
            next

            for i = klen to SHA256_DIGEST_BLOCKLEN - 1
                tb(i) = ipad xor 0
            next
            
            'message = tb(64) | message(mlen)'
            tmplen = SHA256_DIGEST_BLOCKLEN + mlen
            redim tmp(tmplen)
            for i = 0 to SHA256_DIGEST_BLOCKLEN - 1
                tmp(i) = tb(i)
            next
            for i = 0 to mlen - 1
                tmp(SHA256_DIGEST_BLOCKLEN + i) = message(i)
            next

            'hmac = SHA256_Encrypt(message, mlen)
            call SHA256_Encrypt(tmp, tmplen, hmac)

            for i = 0 to klen - 1
                tb(i) = opad xor key(i)
            next

            for i = klen to SHA256_DIGEST_BLOCKLEN - 1
                tb(i) = opad xor 0
            next


            'message = tb(64) | hmac(32)'
            'hmac = SHA256_Encrypt(message)
            tmplen = SHA256_DIGEST_BLOCKLEN + SHA256_DIGEST_VALUELEN
            redim tmp(tmplen)
            for i = 0 to SHA256_DIGEST_BLOCKLEN - 1
                tmp(i) = tb(i)
            next
            for i = 0 to SHA256_DIGEST_VALUELEN - 1
                tmp(SHA256_DIGEST_BLOCKLEN + i) = hmac(i)
            next

            'hmac = SHA256_Encrypt(message, mlen)
            call SHA256_Encrypt(tmp, tmplen, hmac)

            HMAC_SHA256 = 0
            
        end function

        public Function Verify_HMAC_SHA256(message, mlen, key, klen, hmac)
            dim ipad
            dim opad
            dim i
            dim tk(31)
            dim tb(63)
            dim macLen
            dim tmp
            dim tmplen
            dim cmp_hmac(31)

            macLen = SHA256_DIGEST_VALUELEN
            ipad = &H36
            opad = &H5C

            if klen > SHA256_DIGEST_BLOCKLEN then
                call SHA256_Encrypt(key, klen, tk)
                klen = SHA256_DIGEST_VALUELEN
                key = tk
            end if

            for i = 0 To klen - 1
                tb(i) = ipad xor key(i)
            next

            for i = klen to SHA256_DIGEST_BLOCKLEN - 1
                tb(i) = ipad xor 0
            next

            'message = tb(64) | message(mlen)'
            tmplen = SHA256_DIGEST_BLOCKLEN + mlen
            redim tmp(tmplen)
            for i = 0 to SHA256_DIGEST_BLOCKLEN - 1
                tmp(i) = tb(i)
            next
            for i = 0 to mlen - 1
                tmp(SHA256_DIGEST_BLOCKLEN + i) = message(i)
            next

            'hmac = SHA256_Encrypt(message, mlen)
            call SHA256_Encrypt(tmp, tmplen, cmp_hmac)

            for i = 0 to klen - 1
                tb(i) = opad xor key(i)
            next

            for i = klen to SHA256_DIGEST_BLOCKLEN - 1
                tb(i) = opad xor 0
            next

            'message = tb(64) | hmac(32)'
            'hmac = SHA256_Encrypt(message)
            tmplen = SHA256_DIGEST_BLOCKLEN + SHA256_DIGEST_VALUELEN
            redim tmp(tmplen)
            for i = 0 to SHA256_DIGEST_BLOCKLEN - 1
            tmp(i) = tb(i)
            next
            for i = 0 to SHA256_DIGEST_VALUELEN - 1
                tmp(SHA256_DIGEST_BLOCKLEN + i) = cmp_hmac(i)
            next

            'hmac = SHA256_Encrypt(message, mlen)
            call SHA256_Encrypt(tmp, tmplen, cmp_hmac)

            for i = 0 to 31
			    if hmac(i) <> cmp_hmac(i) then
                    Verify_HMAC_SHA256 = 1
				    exit function
			    end if
		    next

            Verify_HMAC_SHA256 = 0
            
        end function
end class 

set KISA_HMAC = new KISA_HMAC_C

%>