import request from '@/utils/request'

// 查询Minio桶列表
export function listBuckets() {
  return request({
    url: '/monitor/minio/buckets',
    method: 'get',
    headers: {
      isToken: false
    }
  })
}

// 查询桶内对象列表
export function listObjects(bucketName) {
  return request({
    url: `/monitor/minio/objects/${bucketName}`,
    method: 'get',
    headers: {
      isToken: false
    }
  })
}

// 创建桶
export function createBucket(bucketName) {
  return request({
    url: `/monitor/minio/buckets/${bucketName}`,
    method: 'post',
    headers: {
      isToken: false
    }
  })
}

// 删除桶
export function deleteBucket(bucketName) {
  return request({
    url: `/monitor/minio/buckets/${bucketName}`,
    method: 'delete',
    headers: {
      isToken: false
    }
  })
}

// 删除对象
export function deleteObject(bucketName, objectName) {
  return request({
    url: `/monitor/minio/objects/${bucketName}/${objectName}`,
    method: 'delete',
    headers: {
      isToken: false
    }
  })
}
