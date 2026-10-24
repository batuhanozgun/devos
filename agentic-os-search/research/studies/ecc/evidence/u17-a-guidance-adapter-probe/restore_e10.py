"""Restore the original E10 archive without rerunning the experiment.

The committed E10.zip.b64 is retained as an identified corrupt transfer.
Only that exact input is accepted. A verified byte splice reconstructs the
original conversation attachment; ZIP SHA-256 and CRC are checked before use.
"""
from pathlib import Path
import base64
import hashlib
import io
import sys
import zipfile

BAD_BLOB = "3b92e3eb9111b10416de99fd88591607e6dea582"
GOOD_B64_BLOB = "4d96ed1e788d7b91783b4d775c520f7639a99055"
ZIP_SHA256 = "d16d24c6b04a17f98d8a62513342170921e05930b883470f123e6d3d4e16888d"
REPLACEMENT = b"NyE0mTKZbzGZfPUGmgXxjMBMY7CPy0UNCD9IRhMRH9mr0lnr2DFMPQItRKAF6+69CQnCN4yzgQ+rR8VOtOCJ7PeIcnE"


def git_blob(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()


def restore(encoded: bytes) -> bytes:
    if git_blob(encoded) != BAD_BLOB:
        raise ValueError("Unexpected encoded evidence identity; refusing repair")
    corrected = encoded[:259] + REPLACEMENT + encoded[356:]
    if git_blob(corrected) != GOOD_B64_BLOB:
        raise ValueError("Corrected base64 identity mismatch")
    archive = base64.b64decode(corrected.rstrip(b"\n"), validate=True)
    if len(archive) != 8821 or hashlib.sha256(archive).hexdigest() != ZIP_SHA256:
        raise ValueError("Original archive identity mismatch")
    with zipfile.ZipFile(io.BytesIO(archive)) as zipped:
        if zipped.testzip() is not None:
            raise ValueError("Archive CRC check failed")
    return archive


def main() -> None:
    source = Path(__file__).with_name("E10.zip.b64")
    destination = Path(sys.argv[1]) if len(sys.argv) == 2 else source.with_name("E10.recovered.zip")
    if len(sys.argv) > 2:
        raise ValueError("Usage: python restore_e10.py [output.zip]")
    archive = restore(source.read_bytes())
    if destination.exists():
        if destination.read_bytes() != archive:
            raise FileExistsError("Refusing to overwrite a different output file")
    else:
        with destination.open("xb") as output:
            output.write(archive)
    print(f"Verified original E10 archive: {destination}; sha256={ZIP_SHA256}")


if __name__ == "__main__":
    main()
