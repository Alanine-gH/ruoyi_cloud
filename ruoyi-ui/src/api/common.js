import request from '@/utils/request'

// 上传书籍封面
export function uploadCover(data) {
  return request({
    url: '/book/detail/uploadCover',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}
